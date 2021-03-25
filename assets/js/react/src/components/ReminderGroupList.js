import React from 'react'
import { useQuery } from 'urql';

const ReminderGroupListQuery = `
  query ListGroups {
    reminderGroupList {
      id
      name
      updatedAt
    }
  }
`;

  const ReminderGroupList = () => {
  const [result, reexecuteQuery] = useQuery({
    query: ReminderGroupListQuery,
    requestPolicy: 'network-only'
  });

  const { data, fetching, error } = result;

  if (fetching) return <p>Loading...</p>;
  if (error) return <p>Oh no... {error.message}</p>;

  return (
    <div>
      <table className="table-auto">
      <thead>
        <tr>
          <th className="px-4 py-2">ID</th>
          <th className="px-4 py-2">Name</th>
          <th className="px-4 py-2">Updated at</th>
        </tr>
      </thead>
      <tbody>
      {data.reminderGroupList.map(group => (
        <tr key={group.id}>
          <td className="border px-4 py-2">{group.id}</td>
          <td className="border px-4 py-2">{group.name}</td>
          <td className="border px-4 py-2">{group.updatedAt}</td>
        </tr>
      ))}
      </tbody>
      </table>
    </div>
  );
};

export default ReminderGroupList;